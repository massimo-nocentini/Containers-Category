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
			baseline: 'ContainersEssentials'
			with: [
			spec repository: 'github://massimo-nocentini/Containers-Essentials:master' ].

		spec
			package: 'Containers-Category'
			with: [ spec requires: #( 'ContainersEssentials' ) ];
			package: 'Containers-Category-Tests'
			with: [ spec requires: #( 'Containers-Category' ) ] ]
]
