Class {
	#name : #LunarButtonListener,
	#superclass : #BlElementEventListener,
	#instVars : [
		'action'
	],
	#category : #'Lunar-Module'
}

{ #category : #'mouse handlers' }
LunarButtonListener >> action: aBloc [
	action := aBloc
]

{ #category : #'mouse handlers' }
LunarButtonListener >> clickEvent: anEvent [
	action value
]
