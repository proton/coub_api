require 'spec_helper'

describe CoubApi do
  it "should return right authorization_url" do
    expect(CoubApi.authorization_url(client_id: 'CLIENT_ID', redirect_uri: 'http://localhost', scope: %i[like repost])).to eq('http://coub.com/oauth/authorize?response_type=code&client_id=CLIENT_ID&redirect_uri=http://localhost&scope=like+repost')
    expect(CoubApi.authorization_url(client_id: 'CLIENT_ID', redirect_uri: 'URI')).to eq('http://coub.com/oauth/authorize?response_type=code&client_id=CLIENT_ID&redirect_uri=URI')
  end

  it "should return error on empty search request" do
    api = CoubApi::Client.new
    expect { api.get(:search) }.to raise_error CoubApi::Error
    expect { api.search }.to raise_error CoubApi::Error
  end

  it "should return search result" do
    api = CoubApi::Client.new

    r = api.get(:search, q: 'test')
    expect(r).to be_a(Hash)
    expect(r).to include('coubs')
    expect(r).to include('total_pages')

    r = api.search(q: 'test')
    expect(r).to be_a(Hash)
    expect(r).to include('coubs')
    expect(r).to include('total_pages')
  end
end