all:
	@echo ""
	@echo "Comandos a ejecutar:"
	@echo ""
	@echo "    ejecutar        Lanza el sitio en modo local."
	@echo ""
	@echo ""


ejecutar:
	jekyll serve --baseurl ''

deploy_a_produccion:
	rm -rf _site
	rm -rf dist
	@echo "Compilando el sitio."
	jekyll build --baseurl ''
	@echo "Clonando repositorio para realizar el deploy."
	git clone dokku@trifulca.space:website dist/
	@echo "Moviendo archivos..."
	@cp -r _site/* dist/
	@echo "Realizando deploy..."
	@cd dist; git add .; git config user.email "trifulcapodcast@gmail.com"; git config user.name "Trifulca Podcast"; git commit -am 'rebuild' --allow-empty; git push -f
	rm -rf _site
	rm -rf dist

