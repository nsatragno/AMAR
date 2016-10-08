# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "AMAR_Embebido"
  spec.version       = '0.0.1'
  spec.authors       = ["Federico Garayalde", "Micaela Iseñ",
                        "Ignacio Wasinger", "Nicolás Satragno"]
  spec.email         = ["garayaldefederico@gmail.com", "micaelaisen@gmail.com",
                        "nacho_35_18@hotmail.com", "nsatragno@gmail.com"]
  spec.summary       = %q{Componente embebido AMAR}
  spec.description   = %q{Aplicación embebida para el Alimentador de Mascotas
                          Automático de Raspberry pi}
  spec.homepage      = "http://satragno.com"
  spec.license       = "GPLv3"

  spec.files         = ['lib/amar_embebido.rb']
  spec.executables   = ['bin/amar_embebido']
  spec.test_files    = ['tests/test_amar_embebido.rb']
  spec.require_paths = ["lib"]
end
