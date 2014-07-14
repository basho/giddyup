#---------------------------
# Tools
#---------------------------

# The minify tool, for minifying CSS and JS
MINIFY := node_modules/.bin/minify
# The jsx tool, for transforming embedded tags in JS
JSX := node_modules/.bin/jsx
# All required JS CLI tools
JSTOOLS := ${MINIFY} ${JSX}

# Installs JS CLI tools via npm
${JSTOOLS}:
	@npm install

#---------------------------
# Directories
#---------------------------

# Source, build, and output directories for JS
SRCJS := priv/assets/javascripts
GENJS := priv/assets/build/javascripts
OUTJS := priv/www/javascripts

# Source, build, and output directories for CSS
SRCCSS := priv/assets/stylesheets
GENCSS := priv/assets/build/stylesheets
OUTCSS := priv/www/stylesheets

# All build directories, including subdirectories
GENDIRS := ${GENJS} ${GENCSS} ${GENJS}/vendor ${GENJS}/app

# Creates build directories
${GENDIRS}:
	@mkdir -p $@

#---------------------------
# Stylesheets
#---------------------------

# Source CSS files, in explicit order
CSS := ${SRCCSS}/bootstrap.css ${SRCCSS}/application.css

# CSS minified target files
MINCSS := $(patsubst ${SRCCSS}/%.css,${GENCSS}/%.min.css,${CSS})

# Copy concatenated/minified CSS to public folder
${OUTCSS}/%.css: ${GENCSS}/%.css
	@echo "Copy $< to $@"
	@cp $< $@

# Concatenate minified CSS
${GENCSS}/application.css: ${MINCSS}
	@echo "Concatenate: $+"
	@cat $+ > $@

# Generate minified CSS from plain CSS
${GENCSS}/%.min.css: ${MINIFY} ${SRCCSS}/%.css
	@echo "Minify: $(lastword $^)"
	@node_modules/.bin/minify --output $@ $(lastword $^)

#---------------------------
# Javascripts
#---------------------------

# Source vendor files, in explicit order.
VENDOR_JS := es5-sham.js \
	     es5-shim.js \
             minispade.js \
	     jquery.js \
	     react.js \
	     routie.js

# Minified vendor JS files
VENDOR_MIN := $(patsubst %.js,${GENJS}/vendor/%.min.js,${VENDOR_JS})

# All application source JS files
APP_SRC := $(shell find ${SRCJS}/app -name "*.js")

# Minified application JS files
APP_MIN := $(patsubst ${SRCJS}/%.js,${GENJS}/%.min.js,${APP_SRC})

# Function to extract a module name for minispade from the filename
jsmodname = $(strip $(patsubst ${GENJS}/app/%.js,%,$(1)))

# Copies concatenated/minified JS to the output directory
${OUTJS}/%.js: ${GENJS}/%.js
	@echo "Copy $< to $@"
	@cp $< $@

# Concatenates all minified application sources to a single file.
${GENJS}/application.js: ${APP_MIN}
	@echo "Concatenate: $+"
	@cat $+ > $@

# Concatenates all minified vendor sources to a single file.
${GENJS}/vendor.js: ${VENDOR_MIN}
	@echo "Concatenate: $+"
	@cat $+ > $@

# Generates minified JS from vendor sources.
${GENJS}/vendor/%.min.js: ${MINIFY} ${GENJS}/vendor ${SRCJS}/vendor/%.js
	@echo "Minify: $(lastword $^)"
	@node_modules/.bin/minify --output $@ $(lastword $^)

# Minified Minispade-wrapped JS files
%.min.js: ${MINIFY} %.spade.js
	@echo "Minify: $(filter %.js,$^)"
	@node_modules/.bin/minify --output $@ $(lastword $^)

# Wrap app modules in minispade
%.spade.js: %.js
	@echo "Minispade: $< as '$(call jsmodname,$<)'"
	@echo "minispade.register('$(call jsmodname,$<)', function(){" > $@
	@cat $< >> $@
	@echo "});" >> $@

# Filter app modules through JSX
${GENJS}/app/%.js: ${JSX} ${GENJS}/app ${SRCJS}/app/%.js
	@echo "JSX: $(filter %.js,$^)"
	@node_modules/.bin/jsx --no-cache-dir $(dir $(lastword $^)) $(@D)

#---------------------------
# Top-level targets
#---------------------------

# Target asset files, concatenated and minified.
ASSETS := priv/www/stylesheets/application.css \
	  priv/www/javascripts/vendor.js \
	  priv/www/javascripts/application.js

# These are fake targets
.PHONY: assets clean_assets

# Installs the build tools, generates build directories and then the
# assets.
assets: ${JSTOOLS} ${GENDIRS} ${ASSETS}

# Adds clean_assets
clean: clean_assets

clean_assets:
	@echo "Removing generated assets:"
	@rm -rfv ${ASSETS} ${GENDIRS}
