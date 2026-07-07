module ApplicationHelper
  def yes_no_badge(value)
    label = value ? "Yes" : "No"
    css = value ? "text-bg-success" : "text-bg-secondary"
    content_tag(:span, label, class: ["badge", css].join(" "))
  end

  # Full-width list row for dashboard cards (arrow is decorative only).
  def dashboard_link_to(label, url, **html_options)
    extra = html_options.delete(:class)
    classes = ["list-group-item", "list-group-item-action", "d-flex", "justify-content-between", "align-items-center", "gap-2", extra].flatten.compact
    link_to url, **html_options, class: classes.join(" ") do
      content_tag(:span, label) +
        content_tag(:span, "→", class: "dashboard-link-chevron text-muted small", "aria-hidden": "true")
    end
  end
end
