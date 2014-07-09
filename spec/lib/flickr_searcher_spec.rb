describe Flickr::Searcher do
  subject { Flickr::Searcher }

  context "when handling parameters" do
    let(:flickr) { double("flickr") }
    before { subject.search params }

    context "if parameters not including a text key" do
      let(:params) { {} }
      it { is_expected.to receive(:search) }
    end
  end

  context "when handling API response" do

  end
end
