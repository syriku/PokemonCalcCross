import XCTest

@testable import PokemonCore

final class TypeEffectivenessTest: XCTestCase {

    var steelEffectiveness: TypeEffectiveness!

    override func setUpWithError() throws {
        steelEffectiveness = TypeEffectiveness(.steel)
    }

    override func tearDownWithError() throws {
        steelEffectiveness = nil
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
}
