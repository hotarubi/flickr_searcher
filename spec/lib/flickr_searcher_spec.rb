describe Flickr::Searcher do
  describe "#search" do
    let(:photos) { double("photos") }
    let(:default_params) { Flickr::Searcher.send :default_query }
    before do
      flickr
      allow($flickraw).to receive(:photos).and_return(photos)
    end

    context "when handling parameters" do
      subject { photos }
      after { Flickr::Searcher.search params }

      context "if parameters not including any search text" do
        let(:params) do
          { max_upload_date: Date.today.to_s }
        end
        it { is_expected.to receive(:search).with(default_params) }
      end

      context "if parameters including all valid keys" do
        let(:params) do
          { text: 'winter',
            min_upload_date: Date.yesterday.to_s,
            max_upload_date: Date.today.to_s,
            sort: 'relevance',
            per_page: 21
          }
        end
        it { is_expected.to receive(:search).with(params) }
      end

      context "if parameters not including valid keys" do
        let(:params) do
          { text: '',
            min_upload_date: Date.yesterday.strftime('%d/%m/%Y'),
            max_upload_date: Date.today.strftime('%d/%m/%Y'),
            sort: 'temperature',
            per_page: 21
          }
        end
        it { is_expected.to receive(:search).with(default_params) }
      end
    end

    context "when handling API response" do
      let(:data) do
        YAML.load(ERB.new(File.read("#{Rails.root}/spec/fixtures/image_list.yml")).result)
      end

      let(:list) do
        FlickRaw::ResponseList.new(
          data[0],
          data[1],
          data[2].map {|e| FlickRaw::Response.new(e.instance_variable_get(:@h), 'photo')}
        )
      end

      let(:urls) do
        YAML.load(ERB.new(File.read("#{Rails.root}/spec/fixtures/image_urls.yml")).result)
      end

      before do
        allow(photos).to receive(:search).and_return(list)
      end

      it "should return sorted urls" do
        expect(Flickr::Searcher.search({text: 'bird'})[:photos]).to eq(urls)
      end

      it "should return pagination info" do
        expect(Flickr::Searcher.search({text: 'bird'})[:info]).to eq(data[0].except('photo'))
      end
    end

  end
end
