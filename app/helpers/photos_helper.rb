module PhotosHelper
  def search_sort_opts
    options_for_select({ 'Earliest Posted' => 'date-posted-asc',
      'Latest Posted' => 'date-posted-desc',
      'Hotest' => 'interestingness-desc',
      'Keyword Relevance' => 'relevance' },
      'interestingness-desc'
    )
  end

  def current_page
    (params[:page] || 1).to_i
  end

  def page_tag(html, page, opts={})
    content_tag :li, opts do
      content_tag :a, html, 'class' => 'pagination-link', 'data-page' => page
    end
  end

  def page_list
    step = 5
    first = [current_page - step, 1].max
    last = [current_page + step, @info[:pages]].min
    return '' if first == last
    content = page_tag('←', [first - step, 1].max)
    (first..last).each do |p|
      content << page_tag(p, p, current_page == p ? {class: 'active'} : {})
    end
    content << page_tag('→', [last + step, @info[:pages]].min)
    content.html_safe
  end
end
