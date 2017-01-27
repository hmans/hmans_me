def list_node(node)
  link_to(node.title, node.url) +
  tag(:ul) do
    node.children.select(&:should_publish?).map do |child|
      tag(:li) do
        list_node(child)
      end
    end.join.html_safe
  end
end

tag(:ul) { list_node(page.root) }
