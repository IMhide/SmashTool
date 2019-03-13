require "graphql/client"
require "graphql/client/http"

GHTTP = GraphQL::Client::HTTP.new("https://api.smash.gg/gql/alpha") do
  def headers(context)
    { "Authorization": "Bearer ef926a96a10fe53f24d940896357e7ac" }
  end
end

Schema  = GraphQL::Client.load_schema(GHTTP)
GraphClient  = GraphQL::Client.new(schema: Schema, execute: GHTTP)

#Stats ak : 2c1c4465447bba4c7b7bf00f2e3d959f
