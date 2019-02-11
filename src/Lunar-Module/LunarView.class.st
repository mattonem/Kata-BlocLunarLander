Class {
	#name : #LunarView,
	#superclass : #BlElement,
	#instVars : [
		'model'
	],
	#category : #'Lunar-Module'
}

{ #category : #drawing }
LunarView >> drawOnSpartaCanvas: aCanvas [
	aCanvas fill
		paint: Color darkGray;
		path: (0 @ 0 extent: self boundsInLocal corner);
		draw.
	aCanvas fill
		paint: Color veryLightGray;
		path: (0 @ 480 extent: self boundsInLocal corner);
		draw
]

{ #category : #acessing }
LunarView >> initialize [
	super initialize.
	self size: 500 @ 500.
	self background: Color darkGray.
	self
		addChild:
			(LunarButton new
				addEventHandler:
					(LunarButtonListener new
						action: [ model isRunning
								ifTrue: [ model stop ]
								ifFalse: [ model start ] ];
						yourself);
				relocate: 20 @ 10;
				yourself)
]

{ #category : #acessing }
LunarView >> model: aLunarModel [ 
	model := aLunarModel.
	model vessel accept: self 
]

{ #category : #visiting }
LunarView >> visitVessel: aLunarVesselModel [
	| inst listener |
	self
		addChild:
			(inst := LunarVesselFuelView new
				model: aLunarVesselModel;
				yourself).
	self
		addChild:
			(inst := LunarVesselView new
				model: aLunarVesselModel;
				addEventHandler: (listener := LunarVesselViewEventListener new yourself);
				requestFocus;
				yourself).
	listener model: inst
]

{ #category : #visiting }
LunarView >> visitVessel: aLunarVesselModel with: aPoint [
	self
		addChild:
			(LunarVesselView new
				relocate: aPoint;
				yourself)
]
