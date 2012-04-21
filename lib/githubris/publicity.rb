module Githubris::Publicity
  def public?
    @attributes[:public]
  end

  def publicize!
    @attributes[:public] = true
  end

  def privatize!
    @attributes[:public] = false
  end
end
