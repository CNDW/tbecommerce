Trashbags.ColorDropdownComponent = Em.Component.extend
	tagName: "div"
	classNames: "btn-group"
	classNameBindings: ['isOpen:open']
	isOpen: false

	actions:
		toggleMenu: ->
			@toggleProperty('isOpen')
		changeColor: (buttonTarget, rule, selectedColor)->
			$(buttonTarget).css(rule, selectedColor)