import Foundation

let rawTypeEffectivenessData: [[Double]] = [
    // .noType
    [
        1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
        1.0,
    ],

    // .normal
    // Weak: Fighting; Immune: Ghost
    [
        1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
        1.0,
    ],

    // .fighting
    // Weak: Flying, Psychic, Fairy; Resist: Rock, Bug, Dark
    [
        1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 0.5,
        2.0,
    ],

    // .flying
    // Weak: Rock, Electric, Ice; Immune: Ground; Resist: Fighting, Bug, Grass
    [
        1.0, 1.0, 0.5, 1.0, 1.0, 0.0, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 0.5, 2.0, 1.0, 2.0, 1.0, 1.0,
        1.0,
    ],

    // .poison
    // Weak: Ground, Psychic; Resist: Fighting, Poison, Bug, Grass, Fairy
    [
        1.0, 1.0, 0.5, 1.0, 0.5, 2.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 2.0, 1.0, 1.0, 1.0,
        0.5,
    ],

    // .ground
    // Weak: Water, Grass, Ice; Immune: Electric; Resist: Poison, Rock
    [
        1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 0.0, 1.0, 2.0, 1.0, 1.0,
        1.0,
    ],

    // .rock
    // Weak: Fighting, Ground, Steel, Water, Grass; Resist: Normal, Flying, Poison, Fire
    [
        1.0, 0.5, 2.0, 0.5, 0.5, 2.0, 1.0, 1.0, 1.0, 2.0, 0.5, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0,
        1.0,
    ],

    // .bug
    // Weak: Flying, Rock, Fire; Resist: Fighting, Ground, Grass
    [
        1.0, 1.0, 0.5, 2.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 2.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0,
        1.0,
    ],

    // .ghost
    // Weak: Ghost, Dark; Immune: Normal, Fighting; Resist: Poison, Bug
    [
        1.0, 0.0, 0.0, 1.0, 0.5, 1.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0,
        1.0,
    ],

    // .steel
    // Weak: Fighting, Ground, Fire; Immune: Poison; Resist: Normal, Flying, Rock, Bug, Steel, Grass, Psychic, Ice, Dragon, Fairy
    [
        1.0, 0.5, 2.0, 0.5, 0.0, 2.0, 0.5, 0.5, 1.0, 0.5, 2.0, 1.0, 0.5, 1.0, 0.5, 0.5, 0.5, 1.0,
        0.5,
    ],

    // .fire
    // Weak: Ground, Rock, Water; Resist: Bug, Steel, Fire, Grass, Ice, Fairy
    [
        1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 0.5, 1.0, 0.5, 0.5, 2.0, 0.5, 1.0, 1.0, 0.5, 1.0, 1.0,
        0.5,
    ],

    // .water
    // Weak: Grass, Electric; Resist: Steel, Fire, Water, Ice
    [
        1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 0.5, 0.5, 2.0, 2.0, 1.0, 0.5, 1.0, 1.0,
        1.0,
    ],

    // .grass
    // Weak: Flying, Poison, Bug, Fire, Ice; Resist: Ground, Water, Grass, Electric
    [
        1.0, 1.0, 1.0, 2.0, 2.0, 0.5, 1.0, 2.0, 1.0, 1.0, 2.0, 0.5, 0.5, 0.5, 1.0, 2.0, 1.0, 1.0,
        1.0,
    ],

    // .electric
    // Weak: Ground; Resist: Flying, Steel, Electric
    [
        1.0, 1.0, 1.0, 0.5, 1.0, 2.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0,
        1.0,
    ],

    // .psychic
    // Weak: Bug, Ghost, Dark; Resist: Fighting, Psychic
    [
        1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 2.0,
        1.0,
    ],

    // .ice
    // Weak: Fighting, Rock, Steel, Fire; Resist: Ice
    [
        1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0,
        1.0,
    ],

    // .dragon
    // Weak: Ice, Dragon, Fairy; Resist: Fire, Water, Grass, Electric
    [
        1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 0.5, 0.5, 0.5, 1.0, 2.0, 2.0, 1.0,
        2.0,
    ],

    // .dark
    // Weak: Fighting, Bug, Fairy; Immune: Psychic; Resist: Ghost, Dark
    [
        1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 0.5,
        2.0,
    ],

    // .fairy
    // Weak: Poison, Steel; Immune: Dragon; Resist: Fighting, Bug, Dark
    [
        1.0, 1.0, 0.5, 1.0, 2.0, 1.0, 1.0, 0.5, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.5,
        1.0,
    ],
]
