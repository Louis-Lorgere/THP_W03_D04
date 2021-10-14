require_relative "../lib/mairie_christmas"

describe "the get_townhall_email method" do
  it "should return an email adress as a string if there is one" do
    expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/ableiges.html")).to eq ("mairie.ableiges95@wanadoo.fr")
    expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/ableiges.html").class).to eq (String)
  end
  it "should return an empty string if there is no email to scrap" do
    expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/vaudherland.html")).to eq ("")
    expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/vaudherland.html").class).to eq (String)
  end
end

describe "the get_townhalls_urls_name method" do
  it "should return an array  185 array of 2 strings, comprised of an url and a town name" do
    expect(get_townhall_urls_and_name("http://annuaire-des-mairies.com/val-d-oise.html").length).to eq(185)
    expect(get_townhall_urls_and_name("http://annuaire-des-mairies.com/val-d-oise.html").class).to eq(Array)
    expect(get_townhall_urls_and_name("http://annuaire-des-mairies.com/val-d-oise.html")[0].length).to eq(2)
    expect(get_townhall_urls_and_name("http://annuaire-des-mairies.com/val-d-oise.html")[0].class).to eq(Array)
    expect(get_townhall_urls_and_name("http://annuaire-des-mairies.com/val-d-oise.html")[0][0].class).to eq(String)
    expect(get_townhall_urls_and_name("http://annuaire-des-mairies.com/val-d-oise.html")[0][1].class).to eq(String)
  end
end

describe "the final array method" do 
  array_url_and_name_towns = get_townhall_urls_and_name("http://annuaire-des-mairies.com/val-d-oise.html")
  value_return = get_townhalls_names_and_emails_array(array_url_and_name_towns)
  it "should return an array of hash composed" do 
    expect(value_return.length).to eq(185)
    expect(value_return.class).to eq(Array)
    expect(value_return[0].length).to eq(1)
    expect(value_return[0].class).to eq(Hash)
  end
  it "each hash should be composed of a name pointing to an adress, or an empty string" do
    expect(value_return[0]["Ableiges"]).to eq("mairie.ableiges95@wanadoo.fr")
    expect(value_return[171]["Vaudherland"]).to eq("")
  end
end