import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobi_health/theme.dart';

class HealthCard extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String subtitle;
  final String mainValue;
  final String trailingIcon;
  final String additionalInfo;

  const HealthCard({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.mainValue,
    required this.trailingIcon,
    required this.additionalInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary_600Color),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      leadingIcon,
                      semanticsLabel: 'Leading Icon'
                    ),
                    const SizedBox(width: 19,),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 16,
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8,),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 15,
                    color: AppColors.gray,
                  ),
                ),
                const SizedBox(height: 2,),
                Text(
                  mainValue,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20,
                    color: AppColors.gray,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SvgPicture.asset(
                trailingIcon,
                semanticsLabel: 'Trailing Icon',
              ),
              const SizedBox(height: 3,),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary_200Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  additionalInfo,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: AppColors.primary_800Color,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
