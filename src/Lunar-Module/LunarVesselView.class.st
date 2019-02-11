Class {
	#name : #LunarVesselView,
	#superclass : #BlElement,
	#instVars : [
		'model',
		'thrustUp'
	],
	#category : #'Lunar-Module'
}

{ #category : #drawing }
LunarVesselView >> drawOnSpartaCanvas: aCanvas [
	| roundedRectangle  |
	roundedRectangle := aCanvas shape
		roundedRectangle: self boundsInLocal
		radii: (BlCornerRadii radius: 3).
	aCanvas clip
		by: roundedRectangle
		during: [ aCanvas fill
				paint: (model dead ifTrue: [Color red] ifFalse:[Color lightBlue]);
				path: self boundsInLocal;
				draw ]
]

{ #category : #drawing }
LunarVesselView >> initialize [
	super initialize.
	self size: 30 @ 30
]

{ #category : #accessing }
LunarVesselView >> model: aLunarVesselModel [ 
	model := aLunarVesselModel.
	self relocate: model position.
	model announcer when: VesselMoved do: [ self relocate: model position. ].
	model announcer when: VesselDies do: [ self invalidate ].
	
]

{ #category : #thrust }
LunarVesselView >> thrustUpStart [
	model thrustUpStart
]

{ #category : #thrust }
LunarVesselView >> thrustUpStop [
	model thrustUpStop
]
