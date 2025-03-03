# coding=utf-8
import sqlite3
import sys
import re
import math
from model import Model
import random
import webbrowser
from geopy.geocoders import Nominatim
import geopandas as gpd
from shapely.geometry import Point
class Job(Model):
    def __init__(self):
        self.con=sqlite3.connect(self.mydb)
        self.con.create_function('sqrt', 1, math.sqrt)
        self.con.create_function('cos', 1, math.cos)
        self.con.create_function('pow', 2, math.pow)
        self.con.row_factory = sqlite3.Row
        self.cur=self.con.cursor()
        self.cur.execute("""create table if not exists job(
        id integer primary key autoincrement,
        name text,
            lat text,
            lon text,
            description text
                    );""")
        self.con.commit()
        #self.con.close()
    def getall(self):
        self.cur.execute("select * from job")

        row=self.cur.fetchall()
        return row
    def deletebyid(self,myid):

        self.cur.execute("delete from job where id = ?",(myid,))
        job=self.cur.fetchall()
        self.con.commit()
        return None
    def getplacesnearby(self,myid):
        sqlcommand2 = """SELECT id,address, sqrt( pow((69.1 * (lat - ?)), 2) + pow((69.1 * (? - lon) * cos(lat / 57.3)), 2)) AS distance FROM job GROUP BY job.id HAVING distance < 50 ORDER BY distance;"""
        self.cur.execute(sqlcommand2,(startlat,startlng))
        rows=self.cur.fetchall()
        return rows
    def getplacenamebyid(self,myid):
        self.cur.execute("select * from job where id = ?",(myid,))
        row=dict(self.cur.fetchone())
        # Génère une coordonnée aléatoire sur terre
        lat, lon = row["lat"], row["lon"]
        print(f"Coordonnée trouvée : {lat}, {lon}")
        geolocator = Nominatim(user_agent="abcdefgh")
        location = geolocator.reverse((lat, lon), language='fr')
        return location
    def getbyid(self,myid):
        self.cur.execute("select * from job where id = ?",(myid,))
        row=dict(self.cur.fetchone())
        print(row["id"], "row id")
        job=self.cur.fetchall()
        return row
    def create(self,params):
        print("ok")
        myhash={}
        for x in params:
            if 'confirmation' in x:
                continue
            if 'envoyer' in x:
                continue
            if '[' not in x and x not in ['routeparams']:
                #print("my params",x,params[x])
                try:
                  myhash[x]=str(params[x].decode())
                except:
                  myhash[x]=str(params[x])
        print("M Y H A S H")
        print(myhash,myhash.keys())
        myid=None
        try:
          self.cur.execute("insert into job (name,lat,lon,description) values (:name,:lat,:lon,:description)",myhash)
          self.con.commit()
          myid=str(self.cur.lastrowid)
        except Exception as e:
          print("my error"+str(e))
        azerty={}
        azerty["job_id"]=myid
        azerty["notice"]="votre job a été ajouté"
        return azerty




