module PhotosHelper
  def search_sort_opts
    options_for_select({ 'Earliest Posted' => 'date-posted-asc',
      'Latest Posted' => 'date-posted-desc',
      'Hotest' => 'interestingness-desc',
      'Keyword Relevance' => 'relevance' },
      'interestingness-desc'
    )
  end

  def page_tag(html, page, opts={})
    content_tag :li, opts do
      content_tag :a, html,
        'href' => '#',
        'class' => 'pagination-link',
        'data-page' => page
    end
  end

  def page_list
    return '' if first_page == last_page
    content = page_tag('«', 1)
    content << page_tag('←', [first_page - page_step - 1, 1].max)
    (first_page..last_page).each do |p|
      content << page_tag(p, p, current_page == p ? {class: 'active'} : {})
    end
    content << page_tag('→', [last_page + page_step + 1, total_pages].min)
    content << page_tag('»', total_pages)
    content.html_safe
  end

  private
  def page_step
    5
  end

  def first_page
    [current_page - page_step, 1].max
  end

  def last_page
    [current_page + page_step, total_pages].min
  end
end
