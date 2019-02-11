Class {
	#name : #LunarVesselModel,
	#superclass : #Object,
	#instVars : [
		'speed',
		'position',
		'announcer',
		'thrustUp',
		'dead',
		'fuel'
	],
	#category : #'Lunar-Module'
}

{ #category : #visiting }
LunarVesselModel >> accept: aLunarView [ 
	^ aLunarView visitVessel: self 
]

{ #category : #visiting }
LunarVesselModel >> accept: aLunarView with: aPoint [ 
	^ aLunarView visitVessel: self with: aPoint
]

{ #category : #visiting }
LunarVesselModel >> addedTo: aLunarModel [
	aLunarModel announcer when: LunarStep do: [ self step ]
]

{ #category : #accessgin }
LunarVesselModel >> announcer [
	^ announcer
]

{ #category : #visiting }
LunarVesselModel >> dead [
	^ dead
]

{ #category : #visiting }
LunarVesselModel >> die [ 
	dead := true.
	self thrustUpStop.
	announcer announce: VesselDies new.
]

{ #category : #visiting }
LunarVesselModel >> fillFuel [
	self fuel: self fuelCapacity.
]

{ #category : #visiting }
LunarVesselModel >> fuel: integer [
	fuel := integer.
	announcer announce: VesselFuelConsumed new
]

{ #category : #visiting }
LunarVesselModel >> fuelCapacity [
	^ 100
]

{ #category : #visiting }
LunarVesselModel >> fuelRatio [
	^ fuel / self fuelCapacity
]

{ #category : #visiting }
LunarVesselModel >> getBorn [
	dead := false.
	self thrustUpStop.
	announcer announce: VesselDies new
]

{ #category : #visiting }
LunarVesselModel >> initialize [ 
	super initialize.
	announcer := Announcer new.
	position := 0@0.
	speed := 0@0.
	thrustUp := false.
	dead := false.
	fuel := self fuelCapacity
]

{ #category : #accessing }
LunarVesselModel >> position [
	^ position
]

{ #category : #accessing }
LunarVesselModel >> position: aPoint [ 
	position := aPoint.
	announcer announce: VesselMoved new.
]

{ #category : #accessing }
LunarVesselModel >> speed: aPoint [ 
	speed := aPoint
]

{ #category : #visiting }
LunarVesselModel >> step [
	speed := speed := speed + (0 @ 0.3).
	(thrustUp and: (fuel > 0))
		ifTrue: [ speed := speed + (0 @ -0.4).
			self fuel: fuel - 1 ].
	(position y > 450 and: speed y > 0)
		ifTrue: [ speed y > 5
				ifTrue: [ self die ].
			speed := 0 @ 0 ].
	self position: position + speed
]

{ #category : #'as yet unclassified' }
LunarVesselModel >> thrustUpStart [
	dead ifFalse: [thrustUp := true.]
]

{ #category : #thrust }
LunarVesselModel >> thrustUpStop [
	thrustUp := false
]
