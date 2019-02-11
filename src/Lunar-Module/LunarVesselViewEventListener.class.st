Class {
	#name : #LunarVesselViewEventListener,
	#superclass : #BlElementEventListener,
	#instVars : [
		'model'
	],
	#category : #'Lunar-Module'
}

{ #category : #accessing }
LunarVesselViewEventListener >> keyDownEvent: anEvent [
	anEvent key = BlKeyboardKey w
		ifTrue: [ ^ model thrustUpStart ].

]

{ #category : #accessing }
LunarVesselViewEventListener >> keyUpEvent: anEvent [
	anEvent key = BlKeyboardKey w
		ifTrue: [ ^ model thrustUpStop ].

]

{ #category : #accessing }
LunarVesselViewEventListener >> model: aModel [
model := aModel
]
