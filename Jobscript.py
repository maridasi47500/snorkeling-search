 class PythonEnRuby
  def initialize(python_code = "print('yeah')")
    @python_code = python_code
    @ruby_code = ""
  end

  def enruby
    @ruby_code = @python_code.dup

    # Convert print statements
    @ruby_code.gsub!(/print\((.*)\)/, 'puts \1')

    # Convert function definitions
    @ruby_code.gsub!(/def (\w+)\((.*)\):/, 'def \1(\2)')

    # Convert class definitions
    @ruby_code.gsub!(/class (\w+):/, 'class \1')

    # Convert instance variables
    @ruby_code.gsub!(/self\.(\w+)/, '@\1')

    # Convert None to nil
    @ruby_code.gsub!(/\bNone\b/, 'nil')

    # Convert True and False
    @ruby_code.gsub!(/\bTrue\b/, 'true')
    @ruby_code.gsub!(/\bFalse\b/, 'false')

    @ruby_code
  end
end

# Exemple d'utilisation
python_code = <<-PYTHON
class Exemple:
    def __init__(self):
        self.valeur = None

    def saluer(self, nom):
        print(f"Bonjour, {nom}!")
        if self.valeur is None:
            print("Valeur non définie")

ok = Exemple()
ok.saluer("Alice")
PYTHON

converter = PythonEnRuby.new(python_code)
puts converter.enruby
