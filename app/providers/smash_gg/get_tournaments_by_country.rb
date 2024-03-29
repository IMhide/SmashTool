class SmashGg::GetTournamentsByCountry
  # Melee ID: 1
  # Tekken ID: 17
  # Ultimate ID : 1386
  # MarioKart8 Deluxe : 2165
  #

  TournamentsQuery = GraphClient.parse <<-'GRAPHQL'
    query($cCode: String!, $perPage: Int!) {
      tournaments(query: {  perPage: $perPage,
                            filter: { countryCode: $cCode, upcoming: true, videogameIds: [1, 1386] },
                            sortBy: "startAt" })
      {
        nodes {
                id
                name
                slug
                city
                addrState
                startAt
                endAt
                mapsPlaceId
                venueAddress
                venueName
                events {
                  videogame {
                    id
                    name
            }  
          }
        }
      }
    }
  GRAPHQL

  def self.call(country: "FR", page_size: 25)
     results = GraphClient.query(TournamentsQuery, variables: {cCode: country, perPage: page_size}).original_hash.dig('data' ,'tournaments', 'nodes')
     format(results.dup)
  end

  def self.videogames(hash)
    hash['events'].select{|e| e.dig('videogame', 'id')}.map{|e| e.dig('videogame', 'name')}.uniq
  end

  def self.format(results)
    results.map do |hash|
      new_hash = hash.dup
      new_hash[:remote_id] = new_hash.delete('id')
      new_hash[:region] = new_hash.delete('addrState')
      new_hash[:start_at] = Time.at(new_hash.delete('startAt'))
      new_hash[:end_at] = Time.at(new_hash.delete('endAt'))
      new_hash[:venue_name] = new_hash.delete('venueName')
      new_hash[:address] = new_hash.delete('venueAddress')
      new_hash[:google_place_id] = new_hash.delete('mapsPlaceId')
      new_hash[:games] = videogames(hash)
      new_hash.delete('events')
      new_hash.with_indifferent_access
    end 
  end

end
