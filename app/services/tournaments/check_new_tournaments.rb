class Tournaments::CheckNewTournaments < ::BaseService
  tee :compute
  tee :persist

  tee :notify_discord

  def compute(input)
    remote_ids = Tournament.all.pluck(:remote_id)
    input[:remote_tournaments] = SmashGg::GetTournamentsByCountry.()

    input[:remote_tournaments].delete_if {|t| remote_ids.include?(t[:remote_id].to_s)}
  end

  def persist(input)
    Tournament.create!(input[:remote_tournaments])
  end

  def notify_discord(input)
    input[:remote_tournaments].each do |tournament|
      start_at = I18n.l(tournament[:start_at], format: :long)
      ClientDiscord.execute do |builder|
        builder.content = 'Un nouveau tournois just appeared'
        builder.add_embed do |embed|
          embed.title = tournament[:name]
          embed.description = "#{tournament[:city]}\nLien: https://smash.gg/#{tournament[:slug]}\n Le: #{start_at}"
          embed.timestamp = Time.now
        end
      end
      sleep 0.5
    end
  end
end
