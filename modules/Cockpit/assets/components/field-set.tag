<field-set>

    <div>

        <div class="uk-alert" if="{!fields.length}">
            { App.i18n.get('Fields definition is missing') }
        </div>

        <div class="uk-margin" each="{field,idx in fields}">
            <label><span class="uk-text-small">{ field.label || field.name || ''}</span></label>
            <div data-is="{ 'field-'+(field.type || 'text') }" class="uk-width-1-1" bind="value.{field.name}" opts="{ (field.options || {}) }"></div>
        </div>

    </div>

    <script>

        this.on('mount', function() { this.trigger('update'); });
        this.on('update', function() { if (opts.opts) App.$.extend(opts, opts.opts); });


        var $this = this;

        this._field = null;

        riot.util.bind(this);

        this.on('mount', function() {
            this.set    = {};
            this.fields = opts.fields || [];
            this.value  = {};

            this.bind = opts.bind || '';
        });

        this.$initBind = function() {
            this.root.$value = this.value;
        };

        this.$updateValue = function(value, field) {

            if (!App.Utils.isObject(value) || Array.isArray(value)) {

                value = {};

                this.fields.forEach(function(field){
                    value[field.name] = null;
                });
            }

            if (JSON.stringify(this.value) != JSON.stringify(value)) {
                this.value = value;
                this.update();
            }

            this._field = field;

        }.bind(this);

        this.on('bindingupdated', function() {
            $this.$setValue(this.value);
        });

    </script>

</field-set>
