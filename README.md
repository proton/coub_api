# CoubApi gem

## Installation

gem install coub_api

## Usage

    api = CoubApi::Client.new
    r = api.get(:search, q: 'test')
    r = api.search(q: 'test')
    r = api.search(q: 'test', api_version: 1)

    oauth_url = CoubApi.authorization_url(client_id: CLIENT_ID, redirect_uri: URI)
    oauth_url = CoubApi.authorization_url(client_id: CLIENT_ID, redirect_uri: URI, scope: %i[like repost])

    api = CoubApi::Client.new(ACCESS_TOKEN, api_version: 2)
    api = CoubApi::Client.new(ACCESS_TOKEN)

    r = api.get('likes/by_channel', channel_id: 1164719)
    r = api.get(:likes, :by_channel, channel_id: 1164719)
    r = api.get(:likes, :by_channel, channel_id: 1164719, access_token: ANOTHER_ACCESS_TOKEN)