module PhotosHelper
  def search_sort_opts
    options_for_select({ 'Earliest Posted' => 'date-posted-asc',
      'Latest Posted' => 'date-posted-desc',
      'Hotest' => 'interestingness-desc',
      'Keyword Relevance' => 'relevance' },
      'interestingness-desc'
    )
  end
end
