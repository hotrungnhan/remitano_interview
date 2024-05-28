# frozen_string_literal: true

RSpec.describe Commands::Movie::Create, type: :service do
  let(:performer) { create(:user) }
  let(:youtube_id) { Faker::Internet.uuid }

  before do
    ENV['GOOGLE_API_KEY'] = 'google_api_key_sample'
  end

  describe 'when #fetch_metadata' do
    context 'when success' do
      let(:mock_data) do
        { title: 'Mock from google API',
          description: 'Description from google API' }
      end

      before do
        stub_request(:get, %r{https://www.googleapis.com/youtube/v3/videos})
          .with(query: hash_including do
                         'key' => 'nexus'
                         'part' => 'snippet'
                         'id' => youtube_id
                       end)
          .to_return(
            status: 200, body: {
              items: [
                {
                  snippet: mock_data
                }
              ]
            }.to_json,
            headers: {}
          )
      end

      it do
        vid_metadata = described_class.new(nil, nil).send(:fetch_metadata, youtube_id)
        expect(vid_metadata).to eq(mock_data)
      end
    end

    context 'when not found video' do
      before do
        stub_request(:get, %r{https://www.googleapis.com/youtube/v3/videos})
          .with(query: hash_including do
                         'key' => 'nexus'
                         'part' => 'snippet'
                         'id' => youtube_id
                       end)
          .to_return(
            status: 200, body: {
              items: []
            }.to_json,
            headers: {}
          )
      end

      it do
        expect do
          described_class.new(nil, nil).send(:fetch_metadata, youtube_id)
        end.to raise_error(Errors::Movie::NotFoundYoutubeVideo)
      end
    end

    context 'when api error' do
      before do
        stub_request(:get, %r{https://www.googleapis.com/youtube/v3/videos})
          .with(query: hash_including do
                         'key' => 'nexus'
                         'part' => 'snippet'
                         'id' => youtube_id
                       end)
          .to_return(
            status: 500, body: {
              items: []
            }.to_json,
            headers: {}
          )
      end

      it do
        expect do
          described_class.new(nil, nil).send(:fetch_metadata, youtube_id)
        end.to raise_error(Errors::Movie::FetchYoutubeMetadata)
      end
    end
  end

  describe 'when #get_id_from_url' do
    context 'with www.youtube.com/watch?v=id' do
      let(:youtube_url) { "https://www.youtube.com/watch?v=#{youtube_id}" }

      it do
        youtube_id_expect = described_class.new(nil, nil).send(:get_id_from_url, youtube_url)
        expect(youtube_id_expect).to eq(youtube_id)
      end
    end

    context 'with youtube.com/shorts/id' do
      let(:youtube_url) { "https://youtube.com/shorts/#{youtube_id}" }

      it do
        youtube_id_expect = described_class.new(nil, nil).send(:get_id_from_url, youtube_url)
        expect(youtube_id_expect).to eq(youtube_id)
      end
    end

    context 'when error' do
      let(:youtube_url) { "https://youtube.com/blabla-notwork/#{youtube_id}" }

      it do
        expect do
          described_class.new(nil, nil).send(:get_id_from_url, youtube_url)
        end.to raise_error(Errors::Movie::BadYoutubeUrl)
      end
    end
  end

  describe 'when success' do
    let(:mock_video_api) do
      { title: 'Mock from google API',
        description: 'Description from google API' }
    end
    let(:params) do
      { youtube_url: "https://www.youtube.com/watch?v=#{youtube_id}" }
    end

    before do
      stub_request(:get, %r{https://www.googleapis.com/youtube/v3/videos})
        .with(query: hash_including do
                       'key' => 'nexus'
                       'part' => 'snippet'
                       'id' => youtube_id
                     end)
        .to_return(
          status: 200, body: {
            items: [
              {
                snippet: mock_video_api
              }
            ]
          }.to_json,
          headers: {}
        )
    end

    it do
      movie = described_class.new(performer, params).exec
      expect(movie.title).to eq(mock_video_api[:title])
      expect(movie.description).to eq(mock_video_api[:description])
      expect(movie.youtube_id).to eq(youtube_id)
      expect(movie.uploader).to eq(user)
    end
  end
end
