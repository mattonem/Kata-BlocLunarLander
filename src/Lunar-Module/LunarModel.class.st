Class {
	#name : #LunarModel,
	#superclass : #Object,
	#instVars : [
		'vessel',
		'announcer',
		'process'
	],
	#category : #'Lunar-Module'
}

{ #category : #instantiation }
LunarModel class >> default [
	| inst |
	inst := self new.
	inst addVessel: self vesselNew .
	^ inst
]

{ #category : #instanciation }
LunarModel class >> vesselNew [
	^ LunarVesselModel new.
]

{ #category : #processing }
LunarModel >> addVessel: aLunarVesselModel [ 
	aLunarVesselModel addedTo: self.
	aLunarVesselModel position: self defaultVesselPosition.
	vessel := aLunarVesselModel.
	
]

{ #category : #processing }
LunarModel >> addVessel: aLunarVesselModel at: aPoint [ 
	aLunarVesselModel addedTo: self.
	aLunarVesselModel position: aPoint.
	vessel := aLunarVesselModel.
	
]

{ #category : #accessing }
LunarModel >> announcer [
	^ announcer
]

{ #category : #processing }
LunarModel >> defaultVesselPosition [
	^ 50@50
]

{ #category : #processing }
LunarModel >> initialize [ 
	super initialize.
	announcer := Announcer new.
	process := [  ] fork
]

{ #category : #processing }
LunarModel >> isRunning [
	^ process isTerminated not
]

{ #category : #accessing }
LunarModel >> start [
	process isTerminated
		ifTrue: [ process terminate ].
	vessel position: self defaultVesselPosition.
	vessel getBorn.
	vessel fillFuel.
	vessel speed: 0@0.
	process := [ [ | delta |
	delta := [ self step ] timeToRun.
	Transcript
		show: delta;
		cr.
	delta < 15 milliSeconds
		ifTrue: [ Transcript
				show: 'fast';
				cr.
			(15 milliSeconds - delta) wait ].
	true ] whileTrue ] fork
]

{ #category : #accessing }
LunarModel >> step [
announcer  announce: LunarStep new.
]

{ #category : #accessing }
LunarModel >> stop [
	process isTerminated ifFalse: [ process terminate ]
	
]

{ #category : #accessing }
LunarModel >> vessel [
	^ vessel
]
