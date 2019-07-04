module UsersHelper
  def build_form_arr(forms)
    form = []
    forms.each do |f|
      form << [f.name, f.id]
    end
    form
  end

  def find_form(user)
    form = Form.find(user.form_id)
    form.name
  end
end
