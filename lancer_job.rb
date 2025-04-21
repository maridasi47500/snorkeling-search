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

links = ["https://destinationlesstravel.com/?s=#{job}+#{pays}"]
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

