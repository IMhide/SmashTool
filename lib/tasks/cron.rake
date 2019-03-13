namespace :cron do
  task new_tournament: :environment do
    Tournaments::CheckNewTournaments.call({})
  end

end
