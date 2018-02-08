# frozen_string_literal: true

# parent helper module
module ApplicationHelper

  def get_title(controller, action)
    case controller
    when "first_steps"
      if action == "new"
        slot_construct = "<h3>Loi Sapin II - Êtes-vous concerné ?</h3>"
      else
        slot_construct = "<h3>Feuille de route</h3>"
      end
    when "second_steps"
      slot_construct = "<h3>Tableau de bord<br>Code de conduite & dispositif d'alerte</h3>"
    when "third_steps"
      slot_construct = "<h3>Tableau de bord<br>Autres dispositions</h3>"
    else
      slot_construct = "<h3>Synthèse</h3>"
    end
    return slot_construct.html_safe
  end

end
