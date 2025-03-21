require 'watir'
require 'addressable/uri'

job=ARGV[0]

ville=ARGV[1]
code=ARGV[2]
pays=ARGV[3]
lat=ARGV[4]
lon=ARGV[5]

# Array of links
links = ["https://recrutement.education.gouv.fr/recrutement/offres?term=#{job}","https://choisirleservicepublic.gouv.fr/nos-offres/filtres/mot-cles/#{job}/","https://fr.linkedin.com/jobs/search?keywords=#{job}&location=#{ville}&geoId=&trk=public_jobs_jobs-search-bar_search-submit&position=1&pageNum=0","https://emplois.inclusion.beta.gouv.fr/search/employers/results?city=#{ville}","https://www.adecco.fr/resultats-offres-emploi/m-#{job}/","https://www.groupeactual.eu/offre-emploi?limit=&order=&keywords=#{job}&adresse=#{ville}%2C%20#{pays}&is_guiana=0&distance=10&niveau-experience=0%3B10&relations%5Bbesoin%5D%5Bcontrat%5D%5Bdebut%5D=&js_range_demarrage_dates=&informations%5Bremunerations%5D=0%3B100000&page=1","https://www.fomatguyane.fr/offres-d-emploi/","https://www.job-interim-guyane.fr/","https://antilles-guyane.fiderim.fr/search?offer_search%5Bsearch%5D=informatique&offer_search%5Bcategory%5D=&offer_search%5Bplaces%5D%5B%5D=35&offer_search%5BagencyOffice%5D=&offer_search%5BactivityArea%5D=&offer_search%5Bjob%5D=&offer_search%5Bsubmit%5D=&offer_search%5B_token%5D=jt6yW_Av1NgWvPQzJ3xO0QnSYzZQS_hvEMGGYuT85ss","https://www.job-interim-guyane.fr/offres-emploi?title=#{job}&secteur_activite=All","https://www.blada.com/recherche/?spe=emploi&mc=#{job}%20#{ville}","https://www.jobijoba.com/fr/query/?what=#{job}&where=#{ville}&where_type=city","https://fr.jooble.org/SearchResult?rgns=#{ville}%2C%20#{pays}&ukw=#{job}","https://www.welcometothejungle.com/fr/jobs?refinementList%5Boffices.country_code%5D%5B%5D=GF&query=#{job}&page=1&aroundLatLng=#{lat}%2C#{lon}&aroundRadius=20&aroundQuery=#{ville}%2C%20#{pays}","https://www.optioncarriere.gf/emploi?s=#{job}&l=#{ville}%2C+#{pays}","https://www.hellowork.com/fr-fr/emploi/recherche.html?k=#{job}&k_autocomplete=&l=#{ville}+#{code}&l_autocomplete=http%3A%2F%2Fwww.rj.com%2Fcommun%2Flocalite%2Fcommune%2F#{code}&st=relevance&d=all","https://fr.indeed.com/jobs?q=informatique&l=#{ville}+%28GF%29&from=searchOnHP%2Cwhatautocomplete&vjk=705d5a5133b8991c","https://candidat.francetravail.fr/offres/recherche?lieux=#{code}&motsCles=#{job}&offresPartenaires=true&range=0-19&rayon=10&tri=0"]

# Open Chromium browser
browser = Watir::Browser.new :firefox

# Open each link in a new tab
links.each do |link|
  yes=Addressable::URI.escape link
  browser.goto(yes) # Go to the first link
  browser.execute_script("window.open('#{link}')") # Open the rest in new tabs
end

# Keep the browser open to view the tabs
sleep 10 # Adjust or remove based on your needs

#
#
#RECRUTEMENT.EDUCATION.GOUV.FR
