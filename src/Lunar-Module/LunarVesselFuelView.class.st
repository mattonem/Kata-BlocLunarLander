Class {
	#name : #LunarVesselFuelView,
	#superclass : #BlElement,
	#instVars : [
		'model'
	],
	#category : #'Lunar-Module'
}

{ #category : #drawing }
LunarVesselFuelView >> drawOnSpartaCanvas: aCanvas [
	| roundedRectangle middlePoint |
	middlePoint := model
		ifNil: [ 0 @ 0 ]
		ifNotNil: [ (0
				@
					(self boundsInLocal corner y
						- (model fuelRatio * self boundsInLocal corner y))) asFloatPoint ].
	roundedRectangle := aCanvas shape
		roundedRectangle: self boundsInLocal
		radii: (BlCornerRadii radius: 3).
	aCanvas clip
		by: roundedRectangle
		during: [ aCanvas fill
				paint: Color lightGray;
				path: self boundsInLocal;
				draw ].
	roundedRectangle := aCanvas shape
		roundedRectangle:
			(self boundsInLocal origin + middlePoint
				extent: self boundsInLocal corner)
		radii: (BlCornerRadii radius: 3).
	aCanvas clip
		by: roundedRectangle
		during: [ aCanvas fill
				paint: Color lightGreen;
				path: self boundsInLocal;
				draw ]
]

{ #category : #drawing }
LunarVesselFuelView >> initialize [
	super initialize.
	self size: 10 @ 500.
	self background: Color lightGray
]

{ #category : #drawing }
LunarVesselFuelView >> model: aLunarVesselModel [ 
	model := aLunarVesselModel.
	model announcer when: VesselFuelConsumed do: [ self invalidate ]
]
