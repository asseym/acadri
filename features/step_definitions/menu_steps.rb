def table_to_list(table)
  data = table.raw
  res = Array.new
  data.each do |rowdata|
    rowdata.each do |entry|
      res << entry
    end
  end
  return res
end

def has_sub_menu?(menu)
  if !menu[:submenus].blank?
    return true
  end
end

def menu_names
  menus = Array.new
  Settings.system_menu.each do |name, menu|
    menus << name.to_s.underscore.humanize.titleize
    if has_sub_menu?(menu)
      menu[:submenus].each do |sub, options|
        menus << sub.to_s.underscore.humanize.titleize
      end
    end
  end
  return menus
end

Then(/^I should see the menu bar$/) do
  within 'div.page-sidebar' do
    expect(page).to have_css("ul.page-sidebar-menu")
  end
end

Then(/^I should see all menus$/) do
  within 'ul.page-sidebar-menu' do
    menu_names.each do |menu|
        expect(page).to have_content menu
    end
  end
end

Then(/^I should see all menus except$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  restricted_menus = table_to_list(table)
  accessible_menus = menu_names - restricted_menus

  accessible_menus.each do |menu|
    within 'ul.page-sidebar-menu' do
      expect(page).to have_content menu
    end
  end

  restricted_menus.each do |menu|
    within 'ul.page-sidebar-menu' do
      expect(page).to_not have_content menu
    end
  end
end