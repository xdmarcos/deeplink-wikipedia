//
//  File.swift
//
//
//  Created by xdmgzdev on 24/03/2021.
//
import UIKit

public class BaseTableViewCell: UITableViewCell {
  public static let reuseIdentifier = "BaseTableViewCellReuseIdentifier"
  private enum ViewTraits {
    // Margins
    static let cellMargins = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 15.0, right: 10.0)
    static let innerMargin: CGFloat = 10.0
    static let vMargin: CGFloat = 5.0

    // Size
    static let typeWidth: CGFloat = 60.0
    static let separatorHeight: CGFloat = 1.0

    // Font size
    static let fontBig: CGFloat = DeviceScreenType.iPhoneBigScreen ? 30.0 : 28.0
    static let fontMedium: CGFloat = 16.0
    static let fontSmall: CGFloat = 12.0

    // UI
    static let numberOfLines = 0
  }

  public enum Accessibility {
    public enum Identifier {
      static var titleLabel = "titleLabel"
      static var symbolLabel = "symbolLabel"
      static var pathLabel = "valueLabel"
    }
  }

  public let titleLabel: UILabel
  public let symbolLabel: UILabel
  public let detailLabel: UILabel
  private let separatorView: UIView

  override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    // symbolLabel
    symbolLabel = UILabel()
    symbolLabel.font = UIFont.boldSystemFont(ofSize: ViewTraits.fontBig)
    symbolLabel.textColor = .darkText
    symbolLabel.textAlignment = .center
    symbolLabel.accessibilityIdentifier = Accessibility.Identifier.symbolLabel

    // titleLabel
    titleLabel = UILabel()
    titleLabel.font = UIFont.boldSystemFont(ofSize: ViewTraits.fontMedium)
    titleLabel.textColor = .darkText
    titleLabel.accessibilityIdentifier = Accessibility.Identifier.titleLabel

    // detailLabel
    detailLabel = UILabel()
    detailLabel.font = UIFont.systemFont(ofSize: ViewTraits.fontSmall)
    detailLabel.textColor = .lightGray
    detailLabel.textAlignment = .left
    detailLabel.lineBreakMode = .byTruncatingHead
    detailLabel.numberOfLines = ViewTraits.numberOfLines
    detailLabel.accessibilityIdentifier = Accessibility.Identifier.pathLabel

    // separatorView
    separatorView = UIView()
    separatorView.backgroundColor = .lightGray

    super.init(style: style, reuseIdentifier: reuseIdentifier)

    selectionStyle = .none
    backgroundColor = .systemBackground

    // Add subviews
    contentView
      .addSubviewsForAutolayout(subviews: [symbolLabel, titleLabel, detailLabel, separatorView])

    // Add constraints
    addCustomConstraints()
  }

  override public func prepareForReuse() {
    super.prepareForReuse()

    titleLabel.text = ""
    symbolLabel.text = ""
    detailLabel.text = ""
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension BaseTableViewCell {
  func addCustomConstraints() {
    NSLayoutConstraint.activate([
      symbolLabel.leadingAnchor.constraint(
        equalTo: contentView.leadingAnchor,
        constant: ViewTraits.innerMargin
      ),
      symbolLabel.widthAnchor
        .constraint(equalToConstant: ViewTraits.typeWidth),
      symbolLabel.centerYAnchor
        .constraint(equalTo: contentView.centerYAnchor),

      titleLabel.leadingAnchor.constraint(
        equalTo: symbolLabel.trailingAnchor,
        constant: ViewTraits.innerMargin
      ),
      titleLabel.trailingAnchor.constraint(
        equalTo: contentView.trailingAnchor,
        constant: -ViewTraits.cellMargins.right
      ),
      titleLabel.topAnchor.constraint(
        equalTo: contentView.topAnchor,
        constant: ViewTraits.cellMargins.top
      ),

      detailLabel.leadingAnchor.constraint(
        equalTo: symbolLabel.trailingAnchor,
        constant: ViewTraits.innerMargin
      ),
      detailLabel.trailingAnchor.constraint(
        equalTo: contentView.trailingAnchor,
        constant: -ViewTraits.cellMargins.right
      ),
      detailLabel.topAnchor.constraint(
        equalTo: titleLabel.bottomAnchor,
        constant: ViewTraits.vMargin
      ),
      detailLabel.bottomAnchor.constraint(
        equalTo: contentView.bottomAnchor,
        constant: -ViewTraits.cellMargins.bottom
      ),

      separatorView.leadingAnchor.constraint(
        equalTo: contentView.leadingAnchor,
        constant: ViewTraits.cellMargins.left
      ),
      separatorView.trailingAnchor.constraint(
        equalTo: contentView.trailingAnchor,
        constant: -ViewTraits.cellMargins.right
      ),
      separatorView.bottomAnchor
        .constraint(equalTo: contentView.bottomAnchor),
      separatorView.heightAnchor
        .constraint(equalToConstant: ViewTraits.separatorHeight),
    ])
  }
}
