require 'watir'
require 'addressable/uri'

job=ARGV[0]

ville=ARGV[1]
code=ARGV[2]

if code[0..1]== "97"
    codedpt=code[0..2]
else
    codedpt=code[0..1]
end
pays=ARGV[3]
lat=ARGV[4]
lon=ARGV[5]
rayon=ARGV[6]

# Array of links
links = ["https://www.flers-emplois.com/emploi/recherche.html?k=#{job}+#{ville}","https://jobs.eiffage.com/toutes-nos-offres?query=#{job}%20#{ville}&page=1","https://www.cyphoma.com/search?utf8=%E2%9C%93&i18n_locale=fr&search%5Bpro%5D=&search%5Border%5D=&search%5Bpage%5D=&search%5Bq%5D=#{job}&search%5Bcategories%5D=&search%5Blocations%5D=4f7cea54c736276288002ce4&search%5Btype%5D=&search%5Burgent%5D=0&search%5Bnew_product%5D=0&search%5Bnew_product%5D=&search%5Bwith_medium%5D=0&commit=","https://www.stages-emplois.com/recherche-emploi.php?qemploi=#{job.downcase}&qville=#{ville.downcase}","https://emploi.lefigaro.fr/offres-emploi/v/#{ville.downcase}-#{code}","https://www.jemepropose.com/annonces/#{ville.downcase}-#{codedpt}/?keywords=#{job}","https://www.adecco.fr/resultats-offres-emploi/d-guyane-fran%C3%A7aise/","https://www.fomatguyane.fr/offres-d-emploi/offres-kourou","https://www.apec.fr/candidat/recherche-emploi.html/emploi?typesConvention=143684&typesConvention=143685&typesConvention=143686&typesConvention=143687&typesConvention=143706&motsCles=#{job}%20#{ville}&page=0","https://recrutement.education.gouv.fr/recrutement/offres?term=#{job}","https://choisirleservicepublic.gouv.fr/nos-offres/filtres/mot-cles/#{job}/","https://fr.linkedin.com/jobs/search?keywords=#{job}&location=#{ville}&geoId=&trk=public_jobs_jobs-search-bar_search-submit&position=1&pageNum=0","https://emplois.inclusion.beta.gouv.fr/search/employers/results?city=#{ville.downcase}-#{codedpt}","https://www.adecco.fr/resultats-offres-emploi/d-guyane-fran%C3%A7aise/","https://www.groupeactual.eu/offre-emploi?limit=&order=&keywords=#{job}&adresse=#{ville}%2C%20#{pays}&is_guiana=0&distance=#{rayon}&niveau-experience=0%3B10&relations%5Bbesoin%5D%5Bcontrat%5D%5Bdebut%5D=&js_range_demarrage_dates=&informations%5Bremunerations%5D=0%3B100000&page=1","https://www.fomatguyane.fr/offres-d-emploi/offres-cayenne","https://www.job-interim-guyane.fr/","https://antilles-guyane.fiderim.fr/","https://www.job-interim-guyane.fr/offres-emploi?title=#{job}&secteur_activite=All","https://www.blada.com/recherche/?spe=emploi&mc=#{job}%20#{ville}","https://www.jobijoba.com/fr/query/?what=#{job}&where=#{ville}&where_type=city","https://fr.jooble.org/SearchResult?rgns=#{ville}%2C%20#{pays}&ukw=#{job}","https://www.welcometothejungle.com/fr/jobs?refinementList%5Boffices.country_code%5D%5B%5D=GF&query=#{job}&page=1&aroundLatLng=#{lat}%2C#{lon}&aroundRadius=20&aroundQuery=#{ville}%2C%20#{pays}","https://www.optioncarriere.gf/emploi?s=#{job}&l=#{ville}%2C+#{pays}","https://www.hellowork.com/fr-fr/emploi/recherche.html?k=#{job}&k_autocomplete=&l=#{ville}+#{code}&l_autocomplete=http%3A%2F%2Fwww.rj.com%2Fcommun%2Flocalite%2Fcommune%2F#{code}&st=relevance&d=all","https://fr.indeed.com/jobs?q=#{job}&l=#{ville}+%28GF%29&from=searchOnHP%2Cwhatautocomplete&vjk=705d5a5133b8991c","https://candidat.francetravail.fr/offres/recherche?lieux=#{code}&motsCles=#{job}&offresPartenaires=true&range=0-19&rayon=#{rayon}&tri=0"]

# Open Chromium browser
browser = Watir::Browser.new :firefox

# Open each link in a new tab
links.each_with_index do |link,i|
  yes=Addressable::URI.escape link
  if i==0
      browser.goto(yes) # Go to the first link
  else
      browser.execute_script("window.open('#{yes}');return false") # Open the rest in new tabs
  end


end
sleep 10
links.each_with_index do |link,i|
  yes=Addressable::URI.escape link



  if yes.include?("fomatguyane") and yes.include?("kourou")
       
      # Switch to the first window
      browser.window(title: 'OFFRES KOUROU - FOMAT GUYANE').use

      browser.execute_script("document.body.innerHTML=document.body.innerHTML.toLowerCase().replace((new RegExp('#{job.downcase}','g')), '<mark>#{job}</mark>');") # Open the rest in new tabs
      browser.window(title: 'OFFRES CAYENNE - FOMAT GUYANE').use
  elsif yes.include?("fiderim")
       
      # Switch to the first window
      browser.window(title: 'Agence d'intérim Antilles-Guyane - Emploi et recrutement | Fiderim').use

      browser.execute_script("offer_search_search.value='#{job}';offer_search.parentElement.submit();") # Open the rest in new tabs
      browser.window(title: 'OFFRES CAYENNE - FOMAT GUYANE').use
  elsif yes.include?("fomatguyane") and yes.include?("cayenne")
       
      # Switch to the first window
      browser.window(title: 'OFFRES CAYENNE - FOMAT GUYANE').use

      browser.execute_script("document.body.innerHTML=document.body.innerHTML.toLowerCase().replace((new RegExp('#{job.downcase}','g')), '<mark>#{job}</mark>');") # Open the rest in new tabs
      browser.window(title: 'OFFRES CAYENNE - FOMAT GUYANE').use
  elsif yes.include?("blada.com")
       
      # Switch to the first window
      browser.window(title: 'Blada.com - Moteur de recherche').use

      browser.execute_script("document.body.innerHTML=document.body.innerHTML.toLowerCase().replace((new RegExp('#{job.downcase}','g')), '<mark>#{job}</mark>');") # Open the rest in new tabs
      browser.window(title: 'OFFRES CAYENNE - FOMAT GUYANE').use
  end

end

# Keep the browser open to view the tabs
sleep 10 # Adjust or remove based on your needs

