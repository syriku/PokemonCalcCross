import XCTest

@testable import PokemonCore

final class TypeEffectivenessTest: XCTestCase {

    var steelEffectiveness: TypeEffectiveness!
    var waterFireEffectiveness: TypeEffectiveness!

    override func setUpWithError() throws {
        steelEffectiveness = TypeEffectiveness(.steel)
        waterFireEffectiveness = TypeEffectiveness(type1: .water, type2: .fire)
    }

    override func tearDownWithError() throws {
        steelEffectiveness = nil
        waterFireEffectiveness = nil
    }

    // MARK: - 钢系防御测试

    /// 钢系有 10 个抗性
    func testSteelHas10Resistances() throws {
        let resistances = steelEffectiveness.defenseSide.halfDamageFrom
        XCTAssertEqual(
            resistances.count, 10,
            "钢系应有 10 个抗性，实际为 \(resistances.count)：\(resistances.map(\.rawValue))"
        )
    }

    func testSteelResistances() throws {
        let resistances = steelEffectiveness.defenseSide.halfDamageFrom
        let expected: [PkmRawType] = [
            .normal, .flying, .rock, .bug, .steel,
            .grass, .psychic, .ice, .dragon, .fairy,
        ]
        for type_ in expected {
            XCTAssertTrue(
                resistances.contains(type_),
                "钢系应该抗 \(type_.rawValue)，但未在抗性列表中找到"
            )
        }
    }

    /// 钢系有 1 个免疫：毒
    func testSteelHas1Immunity() throws {
        let immunities = steelEffectiveness.defenseSide.noDamageFrom
        XCTAssertEqual(
            immunities.count, 1,
            "钢系应有 1 个免疫，实际为 \(immunities.count)：\(immunities.map(\.rawValue))"
        )
    }

    func testSteelIsImmuneToPoison() throws {
        let immunities = steelEffectiveness.defenseSide.noDamageFrom
        XCTAssertTrue(
            immunities.contains(.poison),
            "钢系应免疫毒系"
        )
    }

    /// 钢系有 3 个弱点：火、格斗、地面
    func testSteelHas3Weaknesses() throws {
        let weaknesses = steelEffectiveness.defenseSide.doubleDamageFrom
        XCTAssertEqual(
            weaknesses.count, 3,
            "钢系应有 3 个弱点，实际为 \(weaknesses.count)：\(weaknesses.map(\.rawValue))"
        )
    }

    func testSteelWeaknesses() throws {
        let weaknesses = steelEffectiveness.defenseSide.doubleDamageFrom
        let expected: [PkmRawType] = [.fighting, .ground, .fire]
        for type_ in expected {
            XCTAssertTrue(
                weaknesses.contains(type_),
                "钢系应该弱于 \(type_.rawValue)，但未在弱点列表中找到"
            )
        }
    }

    /// 钢系不应有四倍弱点
    func testSteelHasNoQuadrupleWeakness() throws {
        let quadWeaknesses = steelEffectiveness.defenseSide.quadrupleDamageFrom
        XCTAssertTrue(
            quadWeaknesses.isEmpty,
            "钢系不应有四倍弱点，实际存在：\(quadWeaknesses.map(\.rawValue))"
        )
    }

    // MARK: - 水/火 双属性防御测试

    /// 水/火系有 3 个弱点：地面、岩石、电
    func testWaterFireHas3Weaknesses() throws {
        let weaknesses = waterFireEffectiveness.defenseSide.doubleDamageFrom
        XCTAssertEqual(
            weaknesses.count, 3,
            "水/火系应有 3 个弱点，实际为 \(weaknesses.count)：\(weaknesses.map(\.rawValue))"
        )
    }

    func testWaterFireWeaknesses() throws {
        let weaknesses = waterFireEffectiveness.defenseSide.doubleDamageFrom
        let expected: [PkmRawType] = [.ground, .rock, .electric]
        for type_ in expected {
            XCTAssertTrue(
                weaknesses.contains(type_),
                "水/火系应该弱于 \(type_.rawValue)，但未在弱点列表中找到"
            )
        }
    }

    /// 水/火系有 2 个半减抗性：虫、妖精
    func testWaterFireHas2Resistances() throws {
        let resistances = waterFireEffectiveness.defenseSide.halfDamageFrom
        XCTAssertEqual(
            resistances.count, 2,
            "水/火系应有 2 个半减抗性，实际为 \(resistances.count)：\(resistances.map(\.rawValue))"
        )
    }

    func testWaterFireResistances() throws {
        let resistances = waterFireEffectiveness.defenseSide.halfDamageFrom
        let expected: [PkmRawType] = [.bug, .fairy]
        for type_ in expected {
            XCTAssertTrue(
                resistances.contains(type_),
                "水/火系应该半减 \(type_.rawValue)，但未在抗性列表中找到"
            )
        }
    }

    /// 水/火系有 3 个四分之一抗性：钢、火、冰
    func testWaterFireHas3QuarterResistances() throws {
        let quarterResistances = waterFireEffectiveness.defenseSide.quarterDamageFrom
        XCTAssertEqual(
            quarterResistances.count, 3,
            "水/火系应有 3 个四分之一抗性，实际为 \(quarterResistances.count)：\(quarterResistances.map(\.rawValue))"
        )
    }

    func testWaterFireQuarterResistances() throws {
        let quarterResistances = waterFireEffectiveness.defenseSide.quarterDamageFrom
        let expected: [PkmRawType] = [.steel, .fire, .ice]
        for type_ in expected {
            XCTAssertTrue(
                quarterResistances.contains(type_),
                "水/火系应该四分之一抗 \(type_.rawValue)，但未在抗性列表中找到"
            )
        }
    }

    /// 水/火系不应有四倍弱点
    func testWaterFireHasNoQuadrupleWeakness() throws {
        let quadWeaknesses = waterFireEffectiveness.defenseSide.quadrupleDamageFrom
        XCTAssertTrue(
            quadWeaknesses.isEmpty,
            "水/火系不应有四倍弱点，实际存在：\(quadWeaknesses.map(\.rawValue))"
        )
    }

    /// 水/火系没有免疫
    func testWaterFireHasNoImmunities() throws {
        let immunities = waterFireEffectiveness.defenseSide.noDamageFrom
        XCTAssertTrue(
            immunities.isEmpty,
            "水/火系不应有免疫，实际存在：\(immunities.map(\.rawValue))"
        )
    }

    // MARK: - 水/火 双属性攻击测试

    /// 水/火系有 7 个克制：地面、岩石、火、虫、钢、草、冰
    func testWaterFireHas7SuperEffectiveTargets() throws {
        let superEffective = waterFireEffectiveness.offenseSide.doubleDamageTo
        XCTAssertEqual(
            superEffective.count, 7,
            "水/火系应有 7 个克制，实际为 \(superEffective.count)：\(superEffective.map(\.rawValue))"
        )
    }

    func testWaterFireSuperEffectiveTargets() throws {
        let superEffective = waterFireEffectiveness.offenseSide.doubleDamageTo
        let expected: [PkmRawType] = [.ground, .rock, .fire, .bug, .steel, .grass, .ice]
        for type_ in expected {
            XCTAssertTrue(
                superEffective.contains(type_),
                "水/火系应该克制 \(type_.rawValue)，但未在克制列表中找到"
            )
        }
    }

    /// 水/火系有 2 个微弱：水、龙
    func testWaterFireHas2NotVeryEffectiveTargets() throws {
        let notVeryEffective = waterFireEffectiveness.offenseSide.halfDamageTo
        XCTAssertEqual(
            notVeryEffective.count, 2,
            "水/火系应有 2 个微弱，实际为 \(notVeryEffective.count)：\(notVeryEffective.map(\.rawValue))"
        )
    }

    func testWaterFireNotVeryEffectiveTargets() throws {
        let notVeryEffective = waterFireEffectiveness.offenseSide.halfDamageTo
        let expected: [PkmRawType] = [.water, .dragon]
        for type_ in expected {
            XCTAssertTrue(
                notVeryEffective.contains(type_),
                "水/火系应该微弱于 \(type_.rawValue)，但未在微弱列表中找到"
            )
        }
    }

    /// 水/火系没有无效
    func testWaterFireHasNoIneffectiveTargets() throws {
        let noDamage = waterFireEffectiveness.offenseSide.noDamageTo
        XCTAssertTrue(
            noDamage.isEmpty,
            "水/火系不应有无效目标，实际存在：\(noDamage.map(\.rawValue))"
        )
    }
}
