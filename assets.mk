#---------------------------
# Tools
#---------------------------

# The minify tool, for minifying CSS
MINIFY := node_modules/.bin/minify
# The jsx tool, for transforming embedded tags in JS
JSX := node_modules/.bin/jsx
# The uglifyjs tool, for minifying JS and generating source maps
UGLIFY := node_modules/.bin/uglifyjs
# All required JS CLI tools
JSTOOLS := ${MINIFY} ${UGLIFY} ${JSX}

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
	@${MINIFY} --output $@ $(lastword $^)

#---------------------------
# Javascripts
#---------------------------

# Function to extract a module name for minispade from the filename
jsmodname = $(strip $(patsubst ${GENJS}/app/%.js,%,$(1)))

# Function to derive the source map name from the minified filename
sourcemap = $(strip $(patsubst %.min.js,%.map,$(1)))

# Function to derive the minified filename from the source filename
minjs = $(strip $(patsubst %.spade.js,%.min.js,$(1)))

# Source vendor files, in explicit order.
VENDOR_JS := es5-sham.js \
	     es5-shim.js \
             minispade.js \
	     jquery.js \
	     react.js \
	     routie.js

# Minified vendor JS files
VENDOR_SRC := $(patsubst %.js,${SRCJS}/vendor/%.js,${VENDOR_JS})

# All application source JS files
APP_SRC := $(shell find ${SRCJS}/app -name "*.js" -not -name ".\#*")

# Minified application JS files
APP_SPADE := $(patsubst ${SRCJS}/%.js,${GENJS}/%.spade.js,${APP_SRC})

# Copies concatenated/minified JS to the output directory
${OUTJS}/%.js: ${GENJS}/%.js
	@echo "Copy $< to $@"
	@cp $< $@

# Copies source maps to the output directory
${OUTJS}/%.js.map: ${GENJS}/%.js.map
	@echo "Copy $< to $@"
	@cp $< $@

# Concatenates all minified application sources to a single file.
${GENJS}/application.js.map ${GENJS}/application.js: ${UGLIFY} ${APP_SPADE}
	@echo "Uglify application.js"
	@${UGLIFY} ${APP_SPADE} --source-map ${GENJS}/application.js.map -p $(words $(subst /, ,${GENJS})) \
	    --source-map-include-sources \
            --source-map-url /javascripts/application.js.map \
	    --output ${GENJS}/application.js

# Concatenates all minified vendor sources to a single file.
${GENJS}/vendor.js.map ${GENJS}/vendor.js: ${VENDOR_SRC}
	@echo "Uglify vendor.js"
	@${UGLIFY} ${VENDOR_SRC} --source-map ${GENJS}/vendor.js.map -p $(words $(subst /, ,${GENJS})) \
	    --source-map-include-sources \
            --source-map-url /javascripts/vendor.js.map \
	    --output ${GENJS}/vendor.js

# Wrap app modules in minispade
%.spade.js: %.js
	@echo "Minispade: $< as '$(call jsmodname,$<)'"
	@echo "minispade.register('$(call jsmodname,$<)', function(){" > $@
	@cat $< >> $@
	@echo "});" >> $@

# Filter app modules through JSX
${GENJS}/app/%.js: ${JSX} ${GENJS}/app ${SRCJS}/app/%.js
	@echo "JSX: $(filter %.js,$^)"
	@${JSX} --no-cache-dir $(dir $(lastword $^)) $(@D)

#---------------------------
# Top-level targets
#---------------------------

# Target asset files, concatenated and minified.
ASSETS := priv/www/stylesheets/application.css \
	  priv/www/javascripts/vendor.js \
	  priv/www/javascripts/vendor.js.map \
	  priv/www/javascripts/application.js \
	  priv/www/javascripts/application.js.map \

# These are fake targets
.PHONY: assets clean_assets

# Installs the build tools, generates build directories and then the
# assets.
assets: ${JSTOOLS} ${GENDIRS} ${ASSETS}

# Adds clean_assets
clean: clean_assets

# Cleans generated assets
clean_assets:
	@echo "Removing generated assets:"
	@rm -rfv ${ASSETS} ${GENDIRS}

# If fswatch is installed, watches for changes in the files and then
# runs clean_assets and assets targets.
auto: clean_assets assets
	@fswatch -e '#' -l 3 priv/assets/javascripts priv/assets/stylesheets | \
		xargs -n1 -I{} ${MAKE} clean_assets assets
