Class {
	#name : #LunarModule,
	#superclass : #Object,
	#category : #'Lunar-Module'
}

{ #category : #'as yet unclassified' }
LunarModule class >> exampleStart [
|space model view|
space := BlSpace new.
space extent: 100@500.
model := LunarModel default.
view := LunarView new.
view model: model.
space root addChild: view.
space show.
model inspect
 
]
