module ApplicationHelper
  def user_login_links
    if user_signed_in?
        (link_to "#{current_user.email}", edit_user_registration_path, style: "color:gray;") + " " +
        (link_to "Log Out", destroy_user_session_path, style: "color:gray;",  method: :delete)
    else
      link_to "Log In", new_user_session_path
    end
  end
end
