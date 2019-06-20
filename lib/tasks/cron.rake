namespace :cron do
  task new_tournament: :environment do
    Tournaments::CheckNewTournaments.call({})
  end

  task new_tournament_be: :environement do
  end

end
