import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';

import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/controller/authorization_pupils_controller.dart';

Card authorizationCard(BuildContext context, Authorization authorization) {
  return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => AuthorizationPupils(
                authorization,
              ),
            ));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorization.authorizationName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  SizedBox(
                    width: 250,
                    child: Text(
                      authorization.authorizationDescription,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Column(
                    children: [],
                  )
                ],
              ),
            ],
          ),
        ),
      ));
}
