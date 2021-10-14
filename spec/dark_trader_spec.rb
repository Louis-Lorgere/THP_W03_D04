require_relative "../lib/dark_trader"

describe "get_names-crypto method" do
  PAGE_URL = "https://coinmarketcap.com/all/views/all/"
  page = Nokogiri::HTML(URI.open(PAGE_URL))
  it "should return from an html, an array  fill of 20 cryptos name(string)" do
    expect(get_names_crypto(page).length).to eq(20)
    expect(get_names_crypto(page).class).to eq(Array)
    expect(get_names_crypto(page)[0].class).to eq(String)
    expect(get_names_crypto(page)[0]).to eq("Bitcoin")
    expect(get_names_crypto(page)[1]).to eq("Ethereum")
  end
end

describe "get_values_crypto method" do
  PAGE_URL = "https://coinmarketcap.com/all/views/all/"
  page = Nokogiri::HTML(URI.open(PAGE_URL))
  it "shoud return from an html, an array fill of 20 values (integer)" do
    expect(get_values_crypto(page).length).to eq(20)
    expect(get_values_crypto(page).class).to eq(Array)
    expect(get_values_crypto(page)[0].class).to eq(Float)
    expect(get_values_crypto(page)[0] > 0.0).to eq(true)
    expect(get_values_crypto(page)[1] > 0.0).to eq(true)
  end
end

describe  "get_final_array method" do
  PAGE_URL = "https://coinmarketcap.com/all/views/all/"
  page = Nokogiri::HTML(URI.open(PAGE_URL))
  names = get_names_crypto(page)
  values = get_values_crypto(page) 
  it "should return array of hash of one element, with crypto name pointing to their values" do
    expect(get_final_array(names, values).length).to eq(20)
    expect(get_final_array(names, values).class).to eq(Array)
    expect(get_final_array(names, values)[0].class).to eq(Hash)
    expect(get_final_array(names, values)[0]["Bitcoin"].class).to eq(Float)
    expect(get_final_array(names, values)[1]["Ethereum"].class).to eq(Float)
    expect(get_final_array(names, values)[0]["Bitcoin"] > 0.0).to eq(true)
    expect(get_final_array(names, values)[1]["Ethereum"] > 0.0).to eq(true)
  end
end