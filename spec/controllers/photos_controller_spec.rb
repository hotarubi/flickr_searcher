describe PhotosController, :type => :controller do
  before do
    allow(Flickr::Searcher).to receive(:search).and_return({photos: [], info: {}})
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all @photos" do
      get :index
      expect(assigns(:photos)).to match_array([])
    end
  end

  describe "GET #search" do
    it "responds successfully with an HTTP 200 status code" do
      get :search
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the list template" do
      get :search
      expect(response).to render_template("_list")
    end

    it "loads all @photos" do
      get :search
      expect(assigns(:photos)).to match_array([])
    end
  end

end
