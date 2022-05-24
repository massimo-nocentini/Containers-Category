Class {
	#name : #BaselineOfContainersCategory,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersCategory
}

{ #category : #baselines }
BaselineOfContainersCategory >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: 'Containers-Category';
			package: 'Containers-Category-Tests' ]
]
