require 'spec_helper'

feature "User adds a new link" do
  scenario "when browsing the homepage" do
    expect(Link.count).to eq(0)
    visit '/'
    add_link("www.google.com", "Google", "Search")
    expect(Link.count).to eq(1)
    link = Link.first
    expect(link.url).to eq("www.google.com")
    expect(link.title).to eq("Google")  
    expect(link.blog).to eq("Search")
  end

  def add_link(url, title, blog)
    within('#new-link') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      fill_in 'blog', :with => blog
      click_button 'Add link'
    end
  end

  # def fill_database
  #   Link.create(:url => "https://soundcloud.com/throwingsnow/max-cooper-origins-throwing-snow-remix-2", :title => "Max Cooper", :blog => "Super chilled")
  #   Link.create(:url => "https://soundcloud.com/dj-vadim/dj-vadim-if-life-was-a-thing-ft-demolition-man", :title => "DJ Vadim", :blog => "Sunny goodness")
  #   Link.create(:url => "https://soundcloud.com/born-on-road/stivs-katch-pyro-yuh-no-badman-born-on-road-004-clip", :title => "Stivs", :blog => "Badman Ting")
  #   Link.create(:url => "https://soundcloud.com/c3b/solskank", :title => "C3B", :blog => "Hardcore")
  # end

end