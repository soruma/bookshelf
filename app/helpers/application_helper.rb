# frozen_string_literal: true

module ApplicationHelper
  def menu_item_class(menu_item, title)
    if title.downcase.include?(menu_item.downcase)
      menu_item_current_class
    else
      menu_item_default_class
    end
  end

  def mobile_menu_item_class(menu_item, title)
    if title.downcase.include?(menu_item.downcase)
      mobile_menu_item_current_class
    else
      mobile_menu_item_default_class
    end
  end

  private

  def menu_item_current_class
    'bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium'
  end

  def menu_item_default_class
    'text-gray-300 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium'
  end

  def mobile_menu_item_current_class
    'bg-gray-900 text-white block rounded-md px-3 py-2 text-base font-medium'
  end

  def mobile_menu_item_default_class
    'text-gray-300 hover:bg-gray-700 hover:text-white block rounded-md px-3 py-2 text-base font-medium'
  end
end
