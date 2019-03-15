class Tournaments::CheckNewTournaments < ::BaseService
  tee :compute
  tee :persist
  tee :notify

  def compute(input)
    remote_ids = Tournament.all.pluck(:remote_id)
    input[:remote_tournaments] = SmashGg::GetTournamentsByCountry.()

    input[:remote_tournaments].delete_if {|t| remote_ids.include?(t[:remote_id].to_s)}
  end

  def persist(input)
    Tournament.create!(input[:remote_tournaments])
  end

  def notify(input)
    input[:remote_tournaments].each do |tournament|
      notify_discord(tournament)
      notify_twitter(tournament)
      sleep 0.5
    end
  end

  private

  def notify_discord(tournament)
    start_at = I18n.l(tournament[:start_at], format: :long)
    ClientDiscord.execute do |builder|
      builder.content = 'Un nouveau tournoi just appeared'
      builder.add_embed do |embed|
        embed.title = tournament[:name]
        embed.description = "#{tournament[:city]}\nLien: https://smash.gg/#{tournament[:slug]}\n Le: #{start_at}"
        embed.timestamp = Time.now
      end
    end
  end

  def notify_twitter(tournament)
    start_at = I18n.l(tournament[:start_at], format: :long)
    tweet = "Un nouveau tournoi à #{tournament[:city]}\n#{tournament[:name]}\nDebute le #{start_at}\nhttps://smash.gg/#{tournament[:slug]}\nLieu: #{tournament[:venue_name]} #{tournament[:address]}"
    TwitterClient.update(tweet[0, 280])
  end
end
