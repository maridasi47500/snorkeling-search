require 'watir'
require 'addressable/uri'
require 'i18n'
require 'date'
require 'logger'
def okurl(ok)
    return Addressable::URI.escape(ok)
end

d = DateTime.now
                          #=> #<DateTime: 2007-11-19T08:37:48-0600 ...>
mytime=d.strftime("%m%d%Y%I%M%p")
logger = Logger.new('logs/app'+mytime+'.log', 3, 10 * 1024 * 1024)


I18n.load_path += Dir[File.expand_path("locales") + "/*.yml"]
I18n.default_locale = :fr # (note that `en` is already the default!)
wow=Date.today


myjob=ARGV[0]
job=okurl(ARGV[0])

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
y=rayon.to_i
miles=(rayon.to_f*0.6214).to_i
if miles >= 50
    dist=50
elsif miles >= 25
    dist=25
elsif miles >= 10
    dist=10
elsif miles >= 5
    dist=5
else
    dist=0
end
if y >= 50
    ray=50
elsif y >= 20
    ray=20
elsif y >= 10
    ray=10
elsif y >= 0
    ray=5
else
    ray=0
end
if y >= 50
    jobi=50
elsif y >= 20
    jobi=20
elsif y >= 15
    jobi=15
elsif y >= 10
    jobi=10
elsif y >= 0
    jobi=5
else
    jobi=0
end
if y >= 150
    actu=150
elsif y >= 100
    actu=100
elsif y >= 50
    actu=50
elsif y >= 25
    actu=25
elsif y >= 10
    actu=10
else
    actu=0
end

if y >= 100
    indee=100
elsif y >= 50
    indee=50
elsif y >= 35
    indee=35
elsif y >= 25
    indee=25
elsif y >= 15
    indee=15
elsif y >= 10
    indee=10
elsif y >= 5
    indee=5
else
    indee=0
end
if y >= 100
    inclu=100
elsif y >= 50
    inclu=50
elsif y >= 25
    inclu=25
elsif y >= 15
    inclu=15
elsif y >= 10
    inclu=10
elsif y >= 5
    inclu=5
elsif y >= 2
    inclu=2
else
    inclu=0
end
optionc=inclu
if optionc == 2
   optionc=0
end
talent=optionc


# Array of links

links = ["https://jobs.eiffage.com/toutes-nos-offres?query=#{job}%20#{ville}&page=1","https://candidat.francetravail.fr/offres/recherche?lieux=#{code}&motsCles=#{job}&offresPartenaires=true&range=0-19&rayon=#{rayon}&tri=0","https://fr.talent.com/jobs?k=#{job}&l=#{ville}&radius=#{talent}","https://www.flers-emplois.com/emploi/recherche.html?k=#{job}+#{ville}","https://www.cyphoma.com/search?utf8=%E2%9C%93&i18n_locale=fr&search%5Bpro%5D=&search%5Border%5D=&search%5Bpage%5D=&search%5Bq%5D=#{job}&search%5Bcategories%5D=&search%5Blocations%5D=4f7cea54c736276288002ce4&search%5Btype%5D=&search%5Burgent%5D=0&search%5Bnew_product%5D=0&search%5Bnew_product%5D=&search%5Bwith_medium%5D=0&commit=","https://www.stages-emplois.com/recherche-emploi.php?qemploi=#{job.downcase}&qville=#{ville.downcase}","https://emploi.lefigaro.fr/offres-emploi/v/#{ville.downcase.gsub(" ","-")}-#{code}","https://www.jemepropose.com/annonces/#{ville.downcase}-#{codedpt}/?keywords=#{job}","https://www.adecco.fr/resultats-offres-emploi/d-guyane-fran%C3%A7aise/","https://www.fomatguyane.fr/offres-d-emploi/offres-kourou","https://www.apec.fr/candidat/recherche-emploi.html/emploi?typesConvention=143684&typesConvention=143685&typesConvention=143686&typesConvention=143687&typesConvention=143706&motsCles=#{job}%20#{ville}&page=0","https://recrutement.education.gouv.fr/recrutement/offres?term=#{job}","https://choisirleservicepublic.gouv.fr/nos-offres/filtres/mot-cles/#{job}/","https://fr.linkedin.com/jobs/search?keywords=#{job}&location=#{ville}&geoId=&trk=public_jobs_jobs-search-bar_search-submit&distance=#{dist}&position=1&pageNum=0","https://emplois.inclusion.beta.gouv.fr/search/job-descriptions/results?city=#{ville.downcase}-#{codedpt}&city_name=#{ville}+%28#{codedpt}%29&distance=#{inclu}","https://www.adecco.fr/resultats-offres-emploi/d-#{pays.downcase}","https://www.groupeactual.eu/offre-emploi?limit=&order=#{job.split(" ").select {|x|x.length > 3}.map{|x| "&tags[]=#{x}"}.join("")}&keywords=&adresse=#{ville}%252C%2520#{pays}&is_guiana=0&distance=#{actu}&niveau-experience=0%3B10&relations%5Bbesoin%5D%5Bcontrat%5D%5Bdebut%5D=&js_range_demarrage_dates=&informations%5Bremunerations%5D=0%3B100000&page=1","https://www.fomatguyane.fr/offres-d-emploi/offres-cayenne","https://antilles-guyane.fiderim.fr/","https://www.job-interim-guyane.fr/offres-emploi?title=#{job}&secteur_activite=All","https://www.blada.com/recherche/?spe=emploi&mc=#{job}%20#{ville}","https://www.welcometothejungle.com/fr/jobs?refinementList%5Boffices.country_code%5D%5B%5D=GF&query=#{job}&page=1&aroundLatLng=#{lat}%2C#{lon}&aroundRadius=#{rayon}&aroundQuery=#{ville}%2C%20#{pays}","https://www.hellowork.com/fr-fr/emploi/recherche.html?k=#{job}&k_autocomplete=&l=#{ville}+#{code}&l_autocomplete=http%3A%2F%2Fwww.rj.com%2Fcommun%2Flocalite%2Fcommune%2F#{code}&st=relevance&d=all&ray=#{ray}","https://fr.indeed.com/jobs?q=#{job}&l=#{ville}+%28GF%29&radius=#{indee}&from=searchOnHP%2Cwhatautocomplete&vjk=705d5a5133b8991c","https://fr.jooble.org/SearchResult?rgns=#{ville}%2C%20#{pays}&ukw=#{job}","https://www.jobijoba.com/fr/query/?what=#{job}&where=#{ville}&where_type=city&perimeter=#{jobi}","https://www.optioncarriere.gf/emploi?s=#{job}&l=#{ville}&radius=#{optionc}"]
links.each_slice(10).to_a.each do |myarray|
    # Open Chromium browser
    browser = Watir::Browser.new :firefox
    
    # Open each link in a new tab
    myarray.each_with_index do |link,i|
      yes=link
      begin
          if i==0
              browser.goto(yes) # Go to the first link
          else
              browser.execute_script("window.open('#{yes}');return false") # Open the rest in new tabs
              logger.info("\nje recherche un emploi avec la page numero #{i} : "+link)
          end
      rescue => e
        logger.info("\nil y a eu un probleme pour la page de  "+link+" : "+e.message)
        next
    
      end
    
    
    end
    sleep 10
    
    myarray.each_with_index do |link,i|
      begin
          yes=link

          if myarray.any?{|y|y.include?("kourou") and y.include?("fomatguyane")} and yes.include?("fomatguyane") and yes.include?("kourou")
              logger.info("\n cherche fomat")
               
              # Switch to the first window
              browser.window(title: 'OFFRES KOUROU - FOMAT GUYANE').use
              
              job.downcase.split(" ").each do |wow|
                  browser.execute_script("document.body.innerHTML=document.body.innerHTML.toLowerCase().replace((new RegExp('(#{wow})','g')), '<mark>#{wow}</mark>');") # Open the rest in new tabs
              end
              sleep 0.5
          elsif myarray.any?{|y|y.include?("fiderim")} and yes.include?("fiderim")
              logger.info("\n cherche fiderim")
               
              # Switch to the first window
              browser.window(title: "Agence d'intérim Antilles-Guyane - Emploi et recrutement | Fiderim").use
    
              browser.execute_script("offer_search_search.value='#{job.gsub("'","\'")}'") # Open the rest in new tabs
              browser.execute_script("offer_search.parentElement.submit();") # Open the rest in new tabs
              sleep 0.5
          elsif myarray.any?{|y|y.include?("fomatguyane") and y.include?("cayenn")} and yes.include?("fomatguyane") and yes.include?("cayenne")
               
              # Switch to the first window
              browser.window(title: 'OFFRES CAYENNE - FOMAT GUYANE').use
    
              browser.execute_script("document.body.innerHTML=document.body.innerHTML.toLowerCase().replace((new RegExp('#{job.downcase}','g')), '<mark>#{job}</mark>');") # Open the rest in new tabs
              sleep 0.5
          elsif myarray.any?{|y|y.include?("blada.com")} and yes.include?("blada.com")
              logger.info("\n cherche blada")
               
              # Switch to the first window
              browser.window(title: 'Blada.com - Moteur de recherche').use
    
              browser.execute_script("document.body.innerHTML=document.body.innerHTML.toLowerCase().replace((new RegExp('#{job.downcase}','g')), '<mark>#{job}</mark>');") # Open the rest in new tabs
              sleep 0.5
          #elsif yes.include?("lefigaro")
          #    
          #     
          #    # Switch to the first window
          #    browser.window(title: "Offres Emploi #{ville} (#{code}) - #{I18n.localize(Date.today, format: :figaro).capitalize}").use
          #    browser.execute_script("jQuery('[aria-label=Poste recherché]')[0].value=\"#{job}\"") # Open the rest in new tabs
          #    browser.execute_script("jQuery('[aria-label=Rechercher]')[0].click()") # Open the rest in new tabs
          #    sleep 0.5
    
          elsif myarray.any?{|y|y.include?("choisir")} and yes.include?("choisir")
              logger.info("\n cherche choisir")
               
              # Switch to the first window
              browser.window(title: "Offres d'emploi domaine | Choisir le service public").use
    
              browser.execute_script("document.getElementsByTagName(\"button\")[12].click()") # Open the rest in new tabs
              browser.execute_script("document.getElementsByTagName(\"input\")[30].value=\"#{pays}\"") # Open the rest in new tabs
              browser.execute_script("Array.from(document.getElementsByTagName(\"input\")).filter(x=>x.parentElement.textContent.includes(\"#{pays}\"))[21].checked=true") # Open the rest in new tabs
              browser.execute_script("document.getElementsByClassName(\"actions1\")[0].children[2].click()")
              sleep 0.5
    
          elsif myarray.any?{|y|y.include?("recrutement")} and yes.include?("recrutement")
               
              # Switch to the first window
              logger.info("\n cherche recrutement")
              browser.window(title: 'Trouver une offre').use
              browser.execute_script("document.getElementById(\"OffreEmploi__c_Region__c-36\").click()") # Open the rest in new tabs
              browser.execute_script("Array.from(document.getElementsByTagName(\"input\")).filter(x=>x.parentElement.textContent.includes(\"#{pays.upcase}\"))[0].checked=true") # Open the rest in new tabs
              browser.execute_script("Array.from(document.getElementsByTagName(\"button\")).filter(x=>x.title=(\"Rechercher une offre d'emploi\"))[0].click()") # Open the rest in new tabs
    
              sleep 0.5
    
          elsif myarray.any?{|y|y.include?("cyphoma")} and yes.include?("cyphoma")
               
              logger.info("\n cherche cyphoma")
              # Switch to the first window
              browser.window(title: "Annonces \"#{myjob}\" #{pays} (#{codedpt}) • Cyphoma").use
    
              browser.execute_script("jQuery('[data-label=jobs]')[0].selected=true") # Open the rest in new tabs
              browser.execute_script("search_q.value=\"#{job}\"") # Open the rest in new tabs
              browser.execute_script("new_search.submit()") # Open the rest in new tabs
              sleep 0.5
    
          end
      rescue => e
          logger.error("\nil y a eu un problème pour choisir le metier dans la page : "+e.message)
          next
    
      end
    end
end
#browser.window(title: 'OFFRES CAYENNE - FOMAT GUYANE').use

# Keep the browser open to view the tabs
sleep 10 # Adjust or remove based on your needs

