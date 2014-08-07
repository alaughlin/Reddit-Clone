module ApplicationHelper
  def auth_token
    "<input type=\"hidden\"
      name=\"authenticity_token\"
      value=\"#{ form_authenticity_token }\">".html_safe
  end

  def errors
    html = ""

    if flash[:errors]
      flash[:errors].each do |error|
        html << "#{ error } <br>"
      end
    end

    html.html_safe
  end
end
