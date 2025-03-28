import subprocess
import geopy
from geopy.geocoders import Nominatim
 
# Création d'un objet géocodeur Nominatim

class Scriptruby:
    def __init__(self,name,job,lieu,rayon):
        self.name=name
        self.job=job
        self.lieu=lieu
        self.rayon=rayon
    def lancer(self):
        geolocator = Nominatim(user_agent="my_geocoder")
         
        # Géocodage d'une adresse
        location = geolocator.geocode(self.lieu)
        print(location.raw)
         
        # Affichage des informations de localisation
        print("Adresse:", location.address,"Latitude:", str(location.latitude), "Longitude:", location.longitude)
        code=location.address.split(", ")[-2]
        pays=location.address.split(", ")[-3]
        city=location.address.split(", ")[0]
        try:
            print(" ".join(["sh","./chercher"+self.name+".sh",self.job,city,code, pays, str(location.latitude), str(location.longitude), str(self.rayon)]))
            print("hey !!!")

            x=subprocess.Popen(["sh","./chercher"+self.name+".sh",self.job,city,code, pays, str(location.latitude), str(location.longitude), str(self.rayon)])
        except Exception as e:
            x="blah"
            print(e)
        return x

