module WelcomeHelper
  def categories_script_tag
    content = YAML.load_file(Rails.root.join('config', 'questions.yml')).to_json.html_safe
    content_tag :script, content, type: "text/x-categories-data"
  end
end
